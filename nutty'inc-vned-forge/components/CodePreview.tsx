import React, { useState } from 'react';
import { GeneratedPackage } from '../types';
import { Copy, Check, Play, FileCode, FileJson, FileText } from 'lucide-react';

interface CodePreviewProps {
  packageData: GeneratedPackage | null;
  onRun: (code: string) => void;
  isRunning: boolean;
}

const CodePreview: React.FC<CodePreviewProps> = ({ packageData, onRun, isRunning }) => {
  const [activeTab, setActiveTab] = useState<'source' | 'config' | 'readme'>('source');
  const [copied, setCopied] = useState(false);

  if (!packageData) {
    return (
      <div className="bg-slate-900 border border-slate-800 rounded-xl h-full flex flex-col items-center justify-center p-12 text-slate-500 border-dashed border-2">
        <FileCode className="w-16 h-16 mb-4 opacity-20" />
        <p className="text-lg font-medium">No Package Generated</p>
        <p className="text-sm">Fill out the manifest and forge your package.</p>
      </div>
    );
  }

  const activeContent = packageData[activeTab];

  const handleCopy = () => {
    navigator.clipboard.writeText(activeContent);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  return (
    <div className="bg-slate-900 border border-slate-800 rounded-xl h-full flex flex-col shadow-2xl overflow-hidden">
      {/* Tabs */}
      <div className="flex border-b border-slate-800 bg-slate-950">
        <button
          onClick={() => setActiveTab('source')}
          className={`px-4 py-3 text-sm font-medium flex items-center gap-2 transition-colors border-r border-slate-800 ${
            activeTab === 'source' ? 'text-nutty-400 bg-slate-900' : 'text-slate-500 hover:text-slate-300'
          }`}
        >
          <FileCode className="w-4 h-4" /> main.vned
        </button>
        <button
          onClick={() => setActiveTab('config')}
          className={`px-4 py-3 text-sm font-medium flex items-center gap-2 transition-colors border-r border-slate-800 ${
            activeTab === 'config' ? 'text-nutty-400 bg-slate-900' : 'text-slate-500 hover:text-slate-300'
          }`}
        >
          <FileJson className="w-4 h-4" /> vned.pkg
        </button>
        <button
          onClick={() => setActiveTab('readme')}
          className={`px-4 py-3 text-sm font-medium flex items-center gap-2 transition-colors border-r border-slate-800 ${
            activeTab === 'readme' ? 'text-nutty-400 bg-slate-900' : 'text-slate-500 hover:text-slate-300'
          }`}
        >
          <FileText className="w-4 h-4" /> README.md
        </button>
        <div className="flex-1 bg-slate-950"></div>
        <div className="flex items-center px-2 bg-slate-950 gap-2">
           {activeTab === 'source' && (
            <button
              onClick={() => onRun(packageData.source)}
              disabled={isRunning}
              className="p-2 text-green-500 hover:bg-green-500/10 rounded-md transition-colors"
              title="Run in Interpreter"
            >
              <Play className={`w-4 h-4 ${isRunning ? 'opacity-50' : ''}`} />
            </button>
          )}
          <button
            onClick={handleCopy}
            className="p-2 text-slate-400 hover:text-white hover:bg-slate-800 rounded-md transition-colors"
            title="Copy to Clipboard"
          >
            {copied ? <Check className="w-4 h-4 text-green-500" /> : <Copy className="w-4 h-4" />}
          </button>
        </div>
      </div>

      {/* Editor Area */}
      <div className="flex-1 relative bg-[#0d1117] overflow-hidden">
        <textarea
          readOnly
          value={activeContent}
          className="w-full h-full p-4 bg-transparent text-slate-300 font-mono text-sm outline-none resize-none leading-relaxed"
          spellCheck={false}
        />
        {/* Decorative Language Badge */}
        <div className="absolute bottom-4 right-4 pointer-events-none">
            <span className="text-xs font-bold text-slate-700 bg-slate-900/80 px-2 py-1 rounded border border-slate-800">
                {activeTab === 'source' ? 'VNED' : activeTab === 'config' ? 'JSON' : 'MARKDOWN'}
            </span>
        </div>
      </div>
    </div>
  );
};

export default CodePreview;
