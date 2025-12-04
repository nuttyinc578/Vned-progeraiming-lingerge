export enum VnedPackageType {
  LIBRARY = 'LIBRARY',
  EXECUTABLE = 'EXECUTABLE',
  SERVICE = 'SERVICE'
}

export interface PackageMetadata {
  name: string;
  version: string;
  author: string;
  description: string;
  type: VnedPackageType;
}

export interface GeneratedPackage {
  config: string; // vned.pkg content
  source: string; // main.vned content
  readme: string; // README.md content
}

export interface TerminalLog {
  id: string;
  type: 'info' | 'error' | 'success' | 'output';
  message: string;
  timestamp: number;
}
