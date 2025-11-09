import express from "express";
import { addPrescriptionForPatient } from "../controllers/prescriptionController.js";
const router = express.Router();

router.post("/add", addPrescriptionForPatient);

export default router;
