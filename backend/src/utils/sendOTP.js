// backend/src/utils/sendOTP.js
import nodemailer from "nodemailer";
import { customAlphabet } from "nanoid";

const nanoid = customAlphabet("0123456789", 6);

export function generateOtp() {
  return nanoid();
}

export async function sendOtpEmail(toEmail, otp) {
  const user = process.env.EMAIL_USER;
  const pass = process.env.EMAIL_PASS;

  if (!user || !pass) {
    throw new Error("EMAIL_USER and EMAIL_PASS required in .env");
  }

  const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: { user, pass },
  });

  return transporter.sendMail({
    from: `"Hospital QR" <${user}>`,
    to: toEmail,
    subject: "Your OTP Code",
    html: `<h2>Your OTP Code is: ${otp}</h2><p>This code expires in 5 minutes.</p>`,
  });
}
