import QRCode from "qrcode";
export const genQR = async (text) => QRCode.toDataURL(text);
