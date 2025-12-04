import React from 'react';
import { PackageMetadata, VnedPackageType } from '../types';
import { Sparkles, Save, RotateCcw } from 'lucide-react';

interface PackageFormProps {
  metadata: PackageMetadata;
  setMetadata: React.Dispatch<React.SetStateAction<PackageMetadata>>;
  customPrompt: string;
  setCustomPrompt: (val: string) => void;
  onGenerate: () => void;
  isGenerating: boolean;
}

const PackageForm: React.FC<PackageFormProps> = ({
  metadata,
  setMetadata,
  customPrompt,
  setCustomPrompt,
  onGenerate,
  isGenerating
}) => {
  
  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setMetadata(prev => ({ ...prev, [name]: value }));
  };

  return (
    <div className="bg-slate-800/50 border border-slate-700 rounded-xl p-6 shadow-xl relative overflow-hidden group">
      <div className="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
        <Sparkles className="w-24 h-24 text-nutty-500" />
      </div>

      <h2 className="text-lg font-bold text-white mb-6 flex items-center gap-2">
        <span className="w-2 h-8 bg-nutty-500 rounded-full inline-block"></span>
        Package Manifest
      </h2>

      <div className="space-y-4">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-xs font-semibold text-slate-400 uppercase mb-1">Package Name</label>
            <input
              type="text"
              name="name"
              value={metadata.name}
              onChange={handleChange}
              placeholder="e.g. nutty-utils"
              className="w-full bg-slate-900 border border-slate-700 rounded-lg px-4 py-2 text-white focus:ring-2 focus:ring-nutty-500 focus:border-transparent outline-none transition-all"
            />
          </div>
          <div>
            <label className="block text-xs font-semibold text-slate-400 uppercase mb-1">Version</label>
            <input
              type="text"
              name="version"
              value={metadata.version}
              onChange={handleChange}
              placeholder="1.0.0"
              className="w-full bg-slate-900 border border-slate-700 rounded-lg px-4 py-2 text-white focus:ring-2 focus:ring-nutty-500 focus:border-transparent outline-none transition-all font-mono"
            />
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-xs font-semibold text-slate-400 uppercase mb-1">Author</label>
            <input
              type="text"
              name="author"
              value={metadata.author}
              onChange={handleChange}
              className="w-full bg-slate-900 border border-slate-700 rounded-lg px-4 py-2 text-white focus:ring-2 focus:ring-nutty-500 focus:border-transparent outline-none transition-all"
            />
          </div>
          <div>
            <label className="block text-xs font-semibold text-slate-400 uppercase mb-1">Type</label>
            <select
              name="type"
              value={metadata.type}
              onChange={handleChange}
              className="w-full bg-slate-900 border border-slate-700 rounded-lg px-4 py-2 text-white focus:ring-2 focus:ring-nutty-500 focus:border-transparent outline-none transition-all"
            >
              <option value={VnedPackageType.LIBRARY}>Library</option>
              <option value={VnedPackageType.EXECUTABLE}>Executable</option>
              <option value={VnedPackageType.SERVICE}>Service</option>
            </select>
          </div>
        </div>

        <div>
          <label className="block text-xs font-semibold text-slate-400 uppercase mb-1">Description</label>
          <textarea
            name="description"
            value={metadata.description}
            onChange={handleChange}
            rows={2}
            className="w-full bg-slate-900 border border-slate-700 rounded-lg px-4 py-2 text-white focus:ring-2 focus:ring-nutty-500 focus:border-transparent outline-none transition-all resize-none"
          />
        </div>

        <div className="pt-4 border-t border-slate-700">
          <label className="block text-sm font-semibold text-nutty-400 mb-2 flex items-center gap-2">
            <Sparkles className="w-4 h-4" /> AI Generator Prompt
          </label>
          <textarea
            value={customPrompt}
            onChange={(e) => setCustomPrompt(e.target.value)}
            placeholder="Describe what your package should do in plain English (e.g., 'A calculator that only uses prime numbers')..."
            rows={4}
            className="w-full bg-slate-900/80 border border-slate-600 rounded-lg px-4 py-3 text-slate-200 focus:ring-2 focus:ring-vned-500 focus:border-transparent outline-none transition-all"
          />
        </div>

        <button
          onClick={onGenerate}
          disabled={isGenerating}
          className={`w-full py-4 rounded-lg font-bold text-lg shadow-lg flex items-center justify-center gap-2 transition-all transform active:scale-95 ${
            isGenerating 
              ? 'bg-slate-700 text-slate-400 cursor-not-allowed'
              : 'bg-gradient-to-r from-nutty-500 to-vned-600 text-white hover:shadow-nutty-500/25 hover:from-nutty-400 hover:to-vned-500'
          }`}
        >
          {isGenerating ? (
            <>
              <RotateCcw className="w-5 h-5 animate-spin" /> Forging Vned Code...
            </>
          ) : (
            <>
              <Save className="w-5 h-5" /> Generate Package
            </>
          )}
        </button>
      </div>
    </div>
  );
};

export default PackageForm;
