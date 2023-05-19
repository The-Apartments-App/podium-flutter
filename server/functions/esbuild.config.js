require('esbuild').build({
    entryPoints: ['src/index.js'],
    outfile: 'dist/bundle.js',
    bundle: true,
    target: ['chrome60', 'firefox60', 'safari11', 'edge20'],
    sourcemap: 'inline',
  }).catch(() => process.exit(1))