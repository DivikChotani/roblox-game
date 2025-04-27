import express from "express";
import bodyParser from "body-parser";
import fetch from "node-fetch";
import fs from "fs";
import {GoogleGenerativeAI} from "@google/generative-ai";
import dotenv from "dotenv";
dotenv.config();


const app = express();
const PORT = 8080;

//Fetch all this packages
globalThis.fetch = fetch;
globalThis.Headers = fetch.Headers;
globalThis.Request = fetch.Request;
globalThis.Response = fetch.Response;

app.use(bodyParser.json());


const apikey = process.env.API_KEY;

if (!apikey) {
    console.error("API Key is missing!");
    process.exit(1);
}

const genai = new GoogleGenerativeAI(apikey);

const generationConfig = {
    temperature: 0,
    topP: 0.95,
    topK: 64,
    responseMimeType: "text/plain",
};

async function run(prompt, history) {
    try {
        const model = genai.getGenerativeModel({
            model: "gemini-1.5-flash",
            systemInstruction: "These are the instructions that you give to your Gemini Agent",
        });

        const chatSession = model.startChat({
            generationConfig,
            history: history || [],
        });

        const timeout = (ms) => new Promise((_, reject) => setTimeout(() => reject(new Error("Timeout")), ms));

        const result = await Promise.race([
            chatSession.sendMessage(prompt),
            timeout(10000) // Timeout after 15 seconds
        ]);

        const text = await result.response.text();
        return { Response: true, Text: text };
    } catch (error) {
        console.error("Error in run function: ", error);
        return { Response: false };
    }
}

// Function to fetch content from a URL
async function fetchUrlContent(url) {
    try {
        const response = await fetch(url);
        if (response.ok) {
            const text = await response.text();
            return text;
        } else {
            throw new Error(`Failed to fetch content from URL: ${response.statusText}`);
        }
    } catch (error) {
        console.error("Error fetching URL content:", error);
        return null;
    }
}

// Hardcoded URLs for the content
const url1 = "LINK TO CONTENT I'M BASING MY AGENT ON";
const url2 = "MORE CONTENT";

app.post("/", async (req, res) => {
    const prompt = req.body.prompt;
    const history = req.body.history || [];

    // Fetch the content from both URLs
    let url1Content = '';
    let url2Content = '';

    // Fetch content from the first URL
    // url1Content = await fetchUrlContent(url1);
    // if (!url1Content) {
    //     return res.status(400).send("Failed to fetch content from the first provided URL.");
    // }

    // // Fetch content from the second URL
    // url2Content = await fetchUrlContent(url2);
    // if (!url2Content) {
    //     return res.status(400).send("Failed to fetch content from the second provided URL.");
    // }

    // Combine the content from both URLs with the user prompt
    const fullPrompt = `${url1Content}\n\n${url2Content}\n\nUser Prompt: ${prompt}`;

    // Run the chatbot with the combined prompt
    const response = await run(fullPrompt, history);
    console.log(response)

    if (response.Response) {
        res.status(200).send(response.Text);
    } else {
        res.status(500).send("Server Error");
    }
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));