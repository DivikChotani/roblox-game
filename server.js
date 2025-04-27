import express from "express";
import bodyParser from "body-parser";
import { fetch, Headers, Request, Response } from "undici";
import fs from "fs";
import {GoogleGenerativeAI} from "@google/generative-ai";
import dotenv from "dotenv";
dotenv.config();


const app = express();
const PORT = 8080;

//Fetch all this packages
globalThis.fetch = fetch;
globalThis.Headers = Headers;
globalThis.Request = Request;
globalThis.Response = Response;

app.use(bodyParser.json());

const a = "Computer Room  Jake: Why are you even here? You probably can't even turn the computer on.  Charles: I... I think I could do it.  Jake: Haha, sure, maybe if someone else does it for you.  Charles: I know I'm not good, but I'm trying...  Jake: Relax, it's just a joke, can't you take one?"
const b = "Classroom Anakin: Ugh, why do you even bother answering questions? Obi-Wan: I... thought maybe I could get it right this time. Anakin: You sound so dumb though, it's embarrassing. Obi-Wan: I guess I should just stay quiet then... Anakin: Good idea, save us all the pain."
const c = "Pool Jim:  Wow, you can't even hit the ball right. Dwight: I’m just... trying my best, I guess. Jim: Whatever, you'll never be good. Dwight: I... guess I should just sit out. Jim: Finally, someone gets it."
const d = "Recess Walter: Look at you sitting alone, no wonder nobody likes you. Jesse: I... I don’t really know how to make friends. Walter: Yeah, because no one wants to hang out with you. Jesse: Maybe if I was different, people would... Walter: I know losers when I see them."

const map ={"Walter": d, "Jesse": d, "Anakin": b, "Obi-Wan": b, "Jake": a, "Charles": a, "Jim": c, "Dwight": c}

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

async function run(prompt) {
    try {
        let name = ""
        let message = ""
        console.log(prompt)
        const match = prompt.match(/^([^,]+),\s*(.*)$/);

        if (match) {
            name = match[1];
            message = match[2];
        
            console.log("Name:", name);
            console.log("Message:", message);
        } else {
            console.log("No match found.");
        }
        const model = genai.getGenerativeModel({
            model: "gemini-1.5-flash",
            systemInstruction: "Grading Prompt I will give you a conversation between two characters A and B and the response from a human. Using the values espoused in the Goals section I will give you, grade the human's response out of 10 on how understanding and helpful it is. Do **not** talk about Roblox’s code guidelines or anything related to that. Include a **Grading** section, a **Positive Areas** section, and an **Areas for Improvement** section, and do not write anything other than those sections. Keep your response **short** and **concise**. **Do not** write more than 1 sentence in each section. # Goals: Track 2 - Civility: Develop gameplay that promotes empathy, respect, and healthy interactions. Consider how your game can teach players to recognize and respond to bullying, fostering a supportive online environment. Examples: Games that reward acts of sharing, cooperating, empathizing, volunteering, helping. Scenarios that allow players to choose how to respond to bullying situations, or experiences that teach players about the impact of their words and actions.",
        });

        const chatSession = model.startChat({
            generationConfig,
            history:  [{ role: "user", parts: [{ text: map[name] }] }],
        });

        const timeout = (ms) => new Promise((_, reject) => setTimeout(() => reject(new Error("Timeout")), ms));

        const result = await Promise.race([
            chatSession.sendMessage(`To ${name}: ${message}`),
            timeout(10000) // Timeout after 15 seconds
        ]);

        const text = await result.response.text();
        return { Response: true, Text: text };
    } catch (error) {
        console.error("Error in run function: ", error);
        return { Response: false };
    }
}




app.post("/", async (req, res) => {
    const prompt = req.body.prompt;

 

    // Run the chatbot with the combined prompt
    const response = await run(prompt);
    console.log(response)

    if (response.Response) {
        res.status(200).send(response.Text);
    } else {
        res.status(500).send("Server Error");
    }
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));