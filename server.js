const express = require('express');
const puppeteer = require('puppeteer-core');

const app = express();
app.use(express.json());

async function withPage(fn) {
  const browser = await puppeteer.connect({ browserURL: 'http://127.0.0.1:9222' });
  const page = await browser.newPage();
  try {
    return await fn(page);
  } finally {
    await page.close();
    browser.disconnect();
  }
}

app.post('/pdf', async (req, res) => {
  const { url } = req.body;
  if (!url) return res.status(400).json({ error: 'url required' });
  try {
    const pdf = await withPage(async (page) => {
      await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 30000 });
      return page.pdf({ format: 'A4', printBackground: true });
    });
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', 'attachment; filename="page.pdf"');
    res.send(pdf);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.post('/screenshot', async (req, res) => {
  const { url, fullPage = true } = req.body;
  if (!url) return res.status(400).json({ error: 'url required' });
  try {
    const png = await withPage(async (page) => {
      await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 30000 });
      return page.screenshot({ fullPage, type: 'png' });
    });
    res.setHeader('Content-Type', 'image/png');
    res.send(png);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.post('/html', async (req, res) => {
  const { url } = req.body;
  if (!url) return res.status(400).json({ error: 'url required' });
  try {
    const html = await withPage(async (page) => {
      await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 30000 });
      return page.content();
    });
    res.setHeader('Content-Type', 'text/html; charset=utf-8');
    res.send(html);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.listen(3100, () => console.log('obscura-http on :3100'));
