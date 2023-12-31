# Project Change Log

This file outlines all the significant changes made to the project. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added
- Initial project setup
- Connection to MySQL database - local
- Basic API endpoint for random firstnames


## [0.1.9] - 2023-11-05

### 📦 Added
- Add route `/information-table/system` to show all system.

### 🔄 Changed
- Changes on logic to retrieve language (introduction to language {'fr'}) for `random_pnj` route.

### ⚠️ Deprecated
- Features that were once stable but are no longer recommended and will be removed in future versions.

### 🗑️ Removed
- Features that have been deprecated or outdated and are now removed.

### 🐛 Fixed
- Fix `?suborigin=id` on `/random-pnj` request.
- Fix link between origin and species on `/random-pnj` request

### 🔒 Security
- Implemented any security enhancements.


## [0.1.8] - 2023-11-05


### 🔄 Changed
- Changes on logic to retrieve language (introduction to language {'fr'}) for `information_table` route.

## [0.1.7] - 2023-10-02

### 📦 Added
- New table in database

### 🔄 Changed
- Changes the data value from to database.

## [0.1.6] - 2023-09-27

### 🔄 Changed
- The logic of `global` endpoint.

### ⚠️ Deprecated
- Endpoint `stats` change to `global/stats`.

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

