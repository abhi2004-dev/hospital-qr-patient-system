import mongoose from "mongoose";

const prescriptionSchema = new mongoose.Schema({
  patient: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Patient",
    required: true,
  },
  doctor: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Doctor",
    required: true,
  },
  diagnosis: {
    type: String,
    required: true,
  },
  medications: [
    {
      name: String,
      dosage: String,
      frequency: String,
      duration: String,
    },
  ],
  notes: String,
  prescriptionDate: {
    type: Date,
    default: Date.now,
  },
  pdfUrl: String, // for the generated PDF file
  jsonData: Object, // structured prescription format for integration
});

const Prescription = mongoose.model("Prescription", prescriptionSchema);
export default Prescription;
