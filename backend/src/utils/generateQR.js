// backend/src/utils/generateQR.js
import QRCode from "qrcode";

export async function generateQRCode(payload, opts = {}) {
  const text = typeof payload === "string" ? payload : JSON.stringify(payload);
  const { width = 300 } = opts;

  const dataUrl = await QRCode.toDataURL(text, { width });
  const pngBuffer = Buffer.from(dataUrl.split(",")[1], "base64");

  return { pngBuffer, dataUrl };
}
