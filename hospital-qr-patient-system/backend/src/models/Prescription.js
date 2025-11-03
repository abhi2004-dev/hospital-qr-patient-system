import mongoose from "mongoose";

const prescriptionSchema = new mongoose.Schema({
  patientId: {
    type: String,
    required: true,
  },
  doctorId: {
    type: String,
    required: true,
  },
  diagnosis: String,
  medicines: [
    {
      name: String,
      dosage: String,
      duration: String,
    },
  ],
  notes: String,
  pdfUrl: String, // link to PDF version
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const Prescription = mongoose.model("Prescription", prescriptionSchema);
export default Prescription;
