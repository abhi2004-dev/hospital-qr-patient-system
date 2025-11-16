// src/utils/generateQR.js
const QRCode = require('qrcode');

async function generateQrData(text) {
  return QRCode.toDataURL(text);
}

module.exports = { generateQrData };
