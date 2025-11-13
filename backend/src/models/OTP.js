import mongoose from "mongoose";

const otpSchema = new mongoose.Schema({
  phoneOrEmail: String,
  code: String,
  expiresAt: Date,
  used: { type: Boolean, default: false },
  createdAt: { type: Date, default: Date.now }
});

export default mongoose.model("OTP", otpSchema);
