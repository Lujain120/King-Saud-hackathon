# Service Management Platform

A web application for managing professional services, connecting clients with service providers, and coordinating service delivery.

## Features

- Client-side service browsing and request submission
- Managing team request verification and coordination
- Service provider profiles and request management
- Email notifications for request status updates
- Service categories: Tech, Engineering, Law, Administrative
- Service types: Research, Professional Certification, Courses, Consulting, Volunteering

## Tech Stack

- Frontend: React.js with Material-UI
- Backend: Node.js with Express
- Database: MongoDB
- Authentication: JWT
- Email Service: Nodemailer

## Setup Instructions

1. Clone the repository
2. Install dependencies:
   ```bash
   # Install backend dependencies
   cd backend
   npm install

   # Install frontend dependencies
   cd ../frontend
   npm install
   ```
3. Set up environment variables:
   - Create `.env` file in backend directory
   - Add required environment variables (see .env.example)

4. Start the development servers:
   ```bash
   # Start backend server
   cd backend
   npm run dev

   # Start frontend server
   cd ../frontend
   npm start
   ```

## Project Structure

```
web-app/
├── frontend/           # React frontend application
├── backend/           # Node.js backend server
└── README.md         # Project documentation
``` 