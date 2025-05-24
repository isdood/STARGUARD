# ✨ STARWEAVE API Endpoints

> Quantum-powered API interfaces for system defense

## 🌠 Base URL
\`\`\`
https://api.starweave.quantum/v1
\`\`\`

## 🔐 Authentication

All API endpoints require quantum-signed authentication tokens. See [Authentication](authentication.md) for details.

## 💫 Core Endpoints

### Threat Detection

#### Scan System
\`POST /scan/system\`

Initiates a quantum-enhanced system scan for potential threats.

**Request Headers:**
\`\`\`
Authorization: Bearer <quantum-token>
Content-Type: application/json
\`\`\`

**Request Body:**
\`\`\`json
{
  "scan_depth": "quantum",  // quantum, deep, or surface
  "scan_target": "system",  // system, memory, or network
  "pattern_matching": true    // Enable pattern recognition
}
\`\`\`

**Response:**
\`\`\`json
{
  "scan_id": "qscan_123",
  "status": "initiated",
  "estimated_completion": "2025-05-24T18:30:00Z"
}
\`\`\`

#### Get Scan Results
\`GET /scan/{scan_id}/results\`

Retrieves the results of a quantum system scan.

**Response:**
\`\`\`json
{
  "scan_id": "qscan_123",
  "status": "completed",
  "threats_detected": [
    {
      "id": "threat_789",
      "type": "quantum_anomaly",
      "severity": "critical",
      "location": "memory_sector_42"
    }
  ],
  "quantum_confidence": 0.9995
}
\`\`\`

### Pattern Recognition

#### Analyze Pattern
\`POST /analyze/pattern\`

Submits a pattern for quantum analysis.

**Request Body:**
\`\`\`json
{
  "pattern_data": "base64_encoded_pattern",
  "analysis_type": "quantum_deep"
}
\`\`\`

**Response:**
\`\`\`json
{
  "pattern_id": "pat_456",
  "quantum_match_score": 0.98,
  "similar_patterns": [
    {
      "id": "pat_123",
      "similarity": 0.89,
      "threat_level": "high"
    }
  ]
}
\`\`\`

### System Protection

#### Enable Quantum Shield
\`POST /shield/enable\`

Activates the quantum protection shield.

**Request Body:**
\`\`\`json
{
  "shield_strength": "maximum",
  "coverage_areas": ["memory", "network", "storage"],
  "quantum_entanglement": true
}
\`\`\`

**Response:**
\`\`\`json
{
  "shield_id": "qshield_789",
  "status": "active",
  "protection_level": "quantum_maximum",
  "estimated_uptime": "infinite"
}
\`\`\`

## ⚠️ Rate Limits

- Standard tier: 100 requests per minute
- Quantum tier: 1000 requests per minute
- Enterprise tier: Unlimited requests (quantum-state dependent)

## 🌌 Real-time Connections

For real-time threat detection and pattern analysis:

\`\`\`
wss://api.starweave.quantum/v1/stream
\`\`\`

See [Real-time Events](events.md) for streaming documentation.
