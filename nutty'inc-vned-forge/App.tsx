import React, { useState } from 'react';
import { PackageMetadata, VnedPackageType, GeneratedPackage, TerminalLog } from './types';
import { generateVnedPackage, interpretVnedCode } from './services/geminiService';
import Header from './components/Header';
import PackageForm from './components/PackageForm';
import CodePreview from './components/CodePreview';
import Terminal from './components/Terminal';
import { Github, Twitter } from 'lucide-react';

const App: React.FC = () => {
  const [metadata, setMetadata] = useState<PackageMetadata>({
    name: '',
    version: '0.1.0',
    author: 'NuttyDev',
    description: '',
    type: VnedPackageType.LIBRARY
  });
  
  const [customPrompt, setCustomPrompt] = useState('');
  const [isGenerating, setIsGenerating] = useState(false);
  const [isInterpreting, setIsInterpreting] = useState(false);
  const [generatedPackage, setGeneratedPackage] = useState<GeneratedPackage | null>(null);
  const [logs, setLogs] = useState<TerminalLog[]>([]);

  const addLog = (message: string, type: TerminalLog['type'] = 'info') => {
    setLogs(prev => [...prev, {
      id: Math.random().toString(36).substr(2, 9),
      type,
      message,
      timestamp: Date.now()
    }]);
  };

  const handleGenerate = async () => {
    if (!metadata.name || !customPrompt) {
      addLog("Please provide a package name and a description prompt.", 'error');
      return;
    }

    setIsGenerating(true);
    addLog(`Initiating Nutty Forge for package: ${metadata.name}...`, 'info');

    try {
      const result = await generateVnedPackage(metadata, customPrompt);
      setGeneratedPackage(result);
      addLog("Package forged successfully! Files generated.", 'success');
      addLog("You can now view the source or run the interpreter.", 'info');
    } catch (error: any) {
      addLog(`Forge failed: ${error.message}`, 'error');
    } finally {
      setIsGenerating(false);
    }
  };

  const handleRunCode = async (code: string) => {
    if (!code) return;
    setIsInterpreting(true);
    addLog("Compiling Vned Bytecode...", 'info');
    
    try {
      const output = await interpretVnedCode(code);
      addLog("Execution Result:", 'info');
      addLog(output, 'output');
    } catch (error: any) {
      addLog(`Runtime Error: ${error.message}`, 'error');
    } finally {
      setIsInterpreting(false);
    }
  };

  return (
    <div className="min-h-screen bg-slate-950 text-slate-200 font-sans selection:bg-nutty-500/30">
      <Header />

      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 h-[calc(100vh-8rem)] lg:min-h-[800px]">
          
          {/* Left Panel: Configuration */}
          <div className="lg:col-span-4 flex flex-col gap-6 h-full overflow-y-auto pb-8 pr-2 custom-scrollbar">
            <PackageForm 
              metadata={metadata}
              setMetadata={setMetadata}
              customPrompt={customPrompt}
              setCustomPrompt={setCustomPrompt}
              onGenerate={handleGenerate}
              isGenerating={isGenerating}
            />
            
            <div className="bg-slate-900/50 p-6 rounded-xl border border-slate-800">
              <h3 className="text-nutty-400 font-bold mb-2">Did you know?</h3>
              <p className="text-sm text-slate-400">
                In Vned, the keyword for `try/catch` is <code className="text-vned-400">crack / fix</code>. 
                Always ensure your vibes are checked before deploying to production.
              </p>
            </div>
          </div>

          {/* Right Panel: Editor & Terminal */}
          <div className="lg:col-span-8 flex flex-col gap-6 h-full">
            <div className="flex-1 min-h-[400px]">
              <CodePreview 
                packageData={generatedPackage} 
                onRun={handleRunCode}
                isRunning={isInterpreting}
              />
            </div>
            
            <div className="h-64 shrink-0">
              <Terminal logs={logs} onClear={() => setLogs([])} />
            </div>
          </div>

        </div>
      </main>

      {/* Footer */}
      <footer className="border-t border-slate-800 bg-slate-950 py-6 mt-12">
        <div className="max-w-7xl mx-auto px-4 flex flex-col md:flex-row items-center justify-between text-slate-500 text-sm">
          <p>&copy; {new Date().getFullYear()} Nutty'Inc. All rights reserved.</p>
          <div className="flex items-center gap-6 mt-4 md:mt-0">
             <a href="#" className="hover:text-nutty-400 transition-colors"><Github className="w-5 h-5" /></a>
             <a href="#" className="hover:text-nutty-400 transition-colors"><Twitter className="w-5 h-5" /></a>
             <span className="flex items-center gap-2">
                Powered by <span className="font-bold text-slate-300">Google Gemini</span>
             </span>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default App;
