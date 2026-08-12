/**
 * @type {import('next').NextConfig}
 */
 const nextConfig = {
    basePath: process.env.BASE_PATH || '',
    /* config options here */
    experimental: { appDir: true, }
  }
  
  module.exports = nextConfig