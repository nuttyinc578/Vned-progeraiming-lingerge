import React from 'react';
import { Box, Zap, Terminal } from 'lucide-react';

const Header: React.FC = () => {
  return (
    <header className="border-b border-slate-800 bg-slate-900/80 backdrop-blur-md sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <div className="bg-nutty-500 p-2 rounded-lg rotate-3 shadow-[0_0_15px_rgba(245,158,11,0.5)]">
            <Box className="w-6 h-6 text-slate-900" />
          </div>
          <div>
            <h1 className="text-xl font-bold tracking-tight text-white">
              <span className="text-nutty-400">Nutty'Inc</span> Vned Forge
            </h1>
            <p className="text-xs text-slate-400 font-mono tracking-widest">PACKMGR v9.0.1-rc</p>
          </div>
        </div>

        <nav className="hidden md:flex items-center gap-6">
          <a href="#" className="text-sm font-medium text-slate-300 hover:text-nutty-400 transition-colors flex items-center gap-2">
            <Zap className="w-4 h-4" /> Documentation
          </a>
          <a href="#" className="text-sm font-medium text-slate-300 hover:text-nutty-400 transition-colors flex items-center gap-2">
            <Terminal className="w-4 h-4" /> CLI Tool
          </a>
          <button className="px-4 py-2 bg-slate-800 hover:bg-slate-700 text-sm font-semibold rounded-md text-white transition-all border border-slate-700 hover:border-nutty-500/50">
            Sign In
          </button>
        </nav>
      </div>
    </header>
  );
};

export default Header;
