// backend/src/routes/qrRoutes.js
import express from "express";
import { generateQRCode } from "../utils/generateQR.js";

const router = express.Router();

router.get("/patient/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const payload = { type: "patient", id };

    const { pngBuffer } = await generateQRCode(JSON.stringify(payload), { width: 512 });

    res.setHeader("Content-Type", "image/png");
    res.send(pngBuffer);
  } catch (err) {
    console.error("QR error:", err);
    res.status(500).json({ success: false, message: "QR generation failed" });
  }
});

export default router;
