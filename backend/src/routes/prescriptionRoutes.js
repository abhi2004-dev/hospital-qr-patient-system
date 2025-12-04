import express from "express";
import { 
  addPrescriptionForPatient, 
  getLatestPrescriptionForPatient        // <-- ADD THIS
} from "../controllers/prescriptionController.js";

const router = express.Router();

router.post("/add", addPrescriptionForPatient);
router.get("/latest/:patientId", getLatestPrescriptionForPatient);

export default router;
