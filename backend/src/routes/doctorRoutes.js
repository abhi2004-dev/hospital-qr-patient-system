import express from "express";
import { getDoctorProfile } from "../controllers/doctorController.js";
const router = express.Router();

router.get("/:id", getDoctorProfile);

export default router;
