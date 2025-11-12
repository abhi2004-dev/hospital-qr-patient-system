import express from "express";
import { loginDoctor, registerDoctor } from "../controllers/authController.js";

const router = express.Router();

// Doctor login and register routes
router.post("/doctor/login", loginDoctor);
router.post("/doctor/register", registerDoctor);

export default router;
