import { GoogleGenAI, Type } from "@google/genai";
import { PackageMetadata, GeneratedPackage } from '../types';

// Initialize Gemini Client
const ai = new GoogleGenAI({ apiKey: process.env.API_KEY });
const modelName = 'gemini-2.5-flash';

export const generateVnedPackage = async (
  metadata: PackageMetadata, 
  customPrompt: string
): Promise<GeneratedPackage> => {
  
  const prompt = `
    You are the official package generator for the "Vned" programming language, a quirky, fictional language created by Nutty'Inc.
    
    The Vned language syntax resembles a mix of Rust and Python but uses unique keywords like 'nutty_fn' (function), 'stash' (variable), 'crack' (try/catch), and 'vibe_check' (if).
    
    Create a complete package structure based on the following metadata:
    - Name: ${metadata.name}
    - Version: ${metadata.version}
    - Type: ${metadata.type}
    - Author: ${metadata.author}
    - Description: ${metadata.description}
    - User Requirements: ${customPrompt}

    Return the result as a JSON object with three fields:
    1. 'config': The content of 'vned.pkg' (JSON format metadata for the package).
    2. 'source': The content of 'main.vned' (The entry point source code demonstrating the logic).
    3. 'readme': A Markdown README.md file description.

    Make the code working, commented, and creatively "Nutty".
  `;

  try {
    const response = await ai.models.generateContent({
      model: modelName,
      contents: prompt,
      config: {
        responseMimeType: "application/json",
        responseSchema: {
          type: Type.OBJECT,
          properties: {
            config: { type: Type.STRING },
            source: { type: Type.STRING },
            readme: { type: Type.STRING },
          },
          required: ["config", "source", "readme"]
        }
      }
    });

    const text = response.text;
    if (!text) throw new Error("No response from AI");
    
    return JSON.parse(text) as GeneratedPackage;

  } catch (error) {
    console.error("Error generating package:", error);
    throw error;
  }
};

export const interpretVnedCode = async (code: string): Promise<string> => {
  const prompt = `
    You are the "Vned Interpreter". Execute the following Vned code simulation.
    
    Code:
    ${code}
    
    If the code has syntax errors based on the Vned style (keywords like nutty_fn, stash, vibe_check), explain them.
    Otherwise, simulate the output of the program.
    Return ONLY the console output of the program.
  `;

  try {
    const response = await ai.models.generateContent({
      model: modelName,
      contents: prompt,
    });
    return response.text || "No output generated.";
  } catch (error) {
    console.error("Error interpreting code:", error);
    return "Runtime Error: The Nutty Interpreter crashed due to API issues.";
  }
};
