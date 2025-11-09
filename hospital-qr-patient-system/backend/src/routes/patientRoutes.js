import express from "express";
import { getPatientById, createPatientSample } from "../controllers/patientController.js";
const router = express.Router();

router.get("/:id", getPatientById);

// sample seed endpoint (dev)
router.post("/seed", createPatientSample);

export default router;
