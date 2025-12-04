import React, { useRef, useEffect } from 'react';
import { TerminalLog } from '../types';
import { Terminal as TerminalIcon, XCircle } from 'lucide-react';

interface TerminalProps {
  logs: TerminalLog[];
  onClear: () => void;
}

const Terminal: React.FC<TerminalProps> = ({ logs, onClear }) => {
  const scrollRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (scrollRef.current) {
      scrollRef.current.scrollTop = scrollRef.current.scrollHeight;
    }
  }, [logs]);

  return (
    <div className="bg-slate-950 border border-slate-800 rounded-xl overflow-hidden flex flex-col h-64 md:h-auto shadow-2xl font-mono text-sm relative">
      <div className="bg-slate-900 px-4 py-2 border-b border-slate-800 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <TerminalIcon className="w-4 h-4 text-slate-400" />
          <span className="text-slate-400 font-semibold text-xs">VNED INTERPRETER OUTPUT</span>
        </div>
        <button onClick={onClear} className="text-slate-500 hover:text-red-400 transition-colors">
          <XCircle className="w-4 h-4" />
        </button>
      </div>
      
      <div ref={scrollRef} className="flex-1 p-4 overflow-y-auto space-y-2">
        {logs.length === 0 && (
          <div className="text-slate-600 italic">Ready to run Vned code...</div>
        )}
        {logs.map((log) => (
          <div key={log.id} className="flex gap-2 animate-fade-in">
            <span className="text-slate-600 shrink-0">
              [{new Date(log.timestamp).toLocaleTimeString([], { hour12: false, hour: '2-digit', minute:'2-digit', second:'2-digit' })}]
            </span>
            <span className={`break-words whitespace-pre-wrap ${
              log.type === 'error' ? 'text-red-400' :
              log.type === 'success' ? 'text-green-400' :
              log.type === 'info' ? 'text-blue-400' :
              'text-slate-300'
            }`}>
              {log.type === 'output' && <span className="text-nutty-500 font-bold mr-2">&gt;</span>}
              {log.message}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Terminal;
