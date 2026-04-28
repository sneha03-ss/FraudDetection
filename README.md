# Fraud Detection using Z-Score Analysis in R

## 📌 Project Overview

This project implements a **Fraud Detection System** using statistical anomaly detection based on the **Z-Score method**. The system identifies suspicious financial transactions by detecting values that significantly deviate from the normal transaction pattern.

All statistical calculations such as **mean**, **variance**, and **standard deviation** are implemented manually without using built-in statistical functions. This demonstrates the mathematical foundation behind fraud detection techniques.

The project generates transaction data, analyzes each transaction, classifies fraud cases, visualizes results, and produces an automated report.

---

## 🎯 Objectives

- Detect fraudulent transactions using statistical methods  
- Implement manual Z-Score calculation  
- Visualize transaction anomalies  
- Generate automated fraud detection reports  
- Demonstrate statistical anomaly detection workflow  

---

## 🧠 Methodology

The system follows these steps:

1. Generate transaction dataset  
2. Compute mean manually  
3. Compute standard deviation manually  
4. Calculate Z-Score for each transaction  
5. Compare Z-Score against threshold  
6. Classify transactions as Normal or Fraud  
7. Visualize detected fraud transactions  
8. Generate analysis report  

Fraud Detection Rule:

If:

| Z-score | > 2.5 → Fraud  
| Z-score | ≤ 2.5 → Normal  

---

## 🗂️ Project Structure
