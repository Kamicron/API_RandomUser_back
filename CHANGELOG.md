# Project Change Log

This file outlines all the significant changes made to the project. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added
- Initial project setup
- Connection to MySQL database - local
- Basic API endpoint for random firstnames

## [0.1.5] - 2023-09-26

### 📦 Added
- Add includes option on `random-pnj`.


## [0.1.4] - 2023-08-25

### 📦 Added
- Added a new endpoint for measuring the size of my database.
- Added new work on database
- Added new photo on database
- Added new nationality on database

## [0.1.3] - 2023-09-24

### 📦 Added
- Add new endpoint `/global/ethnic-distribution-by-nationality` to retrieve the distribution of ethny by nationality.

### 🔄 Changed
- Changes `random-pnj`, adding the nationality and distribution ethnicity by nationality.

### ⚠️ Deprecated
- Temporarly delete function `get-all-pnj`.


## [0.1.2] - 2023-09-23

### 📦 Added
- Add endpoint : `get-all-pnj`, to see all pnj on database.
- Add endpoint : `random-pnj`, to create random pnj (not save on database).

### 🔄 Changed
- Changes in existing functionality.


## [0.1.1] - 2023-09-22

### 📦 Added
- installation of core

## [0.1.0] - 2023-09-22

### 📦 Added
- Introduction of the project
- Initial development environment setup

#### Details

- Configured the Nuxt 3 environment
- Setup for TypeScript and SCSS
- Installed and configured MySQL database
- Created initial API routes

####  Challenges

- Had issues with TypeScript types and Nuxt 3 setup
- Encountered database connection issues

### 🐛 Fixed
- Database connection issues
- Minor bugs with TypeScript setup

### 🔄 Changed
- Improved database query performance
- Updated API endpoints

---

## Template for new entries
## [X.X.X] - XXXX-XX-XX

### 📦 Added
- New features that have been added.

### 🔄 Changed
- Changes in existing functionality.

### ⚠️ Deprecated
- Features that were once stable but are no longer recommended and will be removed in future versions.

### 🗑️ Removed
- Features that have been deprecated or outdated and are now removed.

### 🐛 Fixed
- Any bug fixes.

### 🔒 Security
- Implemented any security enhancements.

