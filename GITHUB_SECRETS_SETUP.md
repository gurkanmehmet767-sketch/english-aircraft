# GitHub Secrets Setup Guide 🔐

> **Purpose**: Configure GitHub repository secrets for automated Netlify deployment

## Overview

This guide will help you set up the required GitHub Secrets to enable automated deployment to Netlify via GitHub Actions.

## Required Secrets

Your repository needs the following secrets for CI/CD:

### 1. `NETLIFY_AUTH_TOKEN` 🔑

**Purpose**: Authenticate GitHub Actions to deploy to your Netlify account

**How to Get It:**

1. Go to [Netlify](https://app.netlify.com)
2. Log in to your account
3. Click on your profile picture (top right)
4. Select **User settings**
5. Navigate to **Applications** → **Personal access tokens**
6. Click **New access token**
7. Give it a name (e.g., "GitHub Actions Deploy")
8. Click **Generate token**
9. **Copy the token immediately** (you won't see it again!)

### 2. `NETLIFY_SITE_ID` 🌐

**Purpose**: Identify which Netlify site to deploy to

**How to Get It:**

1. Go to [Netlify](https://app.netlify.com)
2. Click on your **cool-lily-c480e7** site
3. Go to **Site settings**
4. Under **Site details**, find **Site ID**
5. Copy the Site ID: `7023e14b-80c2-4c2d-b5c6-6d70f6099cbc`

---

## Adding Secrets to GitHub

Once you have both values, add them to your GitHub repository:

### Step-by-Step:

1. **Go to Your Repository**:
   - Navigate to: https://github.com/gurkanmehmet767-sketch/english-aircraft

2. **Access Settings**:
   - Click on **Settings** tab (top menu)
   - ⚠️ *You need admin/write access to the repository*

3. **Navigate to Secrets**:
   - In the left sidebar, expand **Secrets and variables**
   - Click **Actions**

4. **Add New Secret**:
   - Click **New repository secret** button

5. **Add NETLIFY_AUTH_TOKEN**:
   - **Name**: `NETLIFY_AUTH_TOKEN`
   - **Value**: Paste your Netlify personal access token
   - Click **Add secret**

6. **Add NETLIFY_SITE_ID**:
   - Click **New repository secret** again
   - **Name**: `NETLIFY_SITE_ID`
   - **Value**: Paste your Netlify site ID
   - Click **Add secret**

---

## Verify Setup

After adding secrets:

1. Go to **Settings** → **Secrets and variables** → **Actions**
2. You should see:
   - ✅ `NETLIFY_AUTH_TOKEN`
   - ✅ `NETLIFY_SITE_ID`

---

## Enable Netlify Deployment in Workflow

Once secrets are added, uncomment the deployment section in GitHub Actions:

**File**: `.github/workflows/flutter.yml`

**Current Status** (lines 78-101): Commented out

**To Enable**:
1. Open `.github/workflows/flutter.yml`
2. Uncomment lines 78-99 (remove the `#` at the start of each line)
3. Delete or comment out lines 100-101 (the NOTE)
4. Commit and push changes

**After enabling**, every push to `main` will:
1. ✅ Run code analysis
2. ✅ Run all tests
3. ✅ Build web version
4. ✅ **Deploy to Netlify automatically** 🚀

---

## Current Deployment URL

**Live Site**: https://cool-lily-c480e7.netlify.app
**Site ID**: `7023e14b-80c2-4c2d-b5c6-6d70f6099cbc`

---

## Troubleshooting

### Issue: "Secret not found" error in Actions

**Solution**: 
- Verify secret names are EXACTLY `NETLIFY_AUTH_TOKEN` and `NETLIFY_SITE_ID` (case-sensitive)
- Check you have write access to the repository

### Issue: "Invalid token" error

**Solution**:
- Generate a new Netlify personal access token
- Update the GitHub secret with the new value

### Issue: "Site not found" error

**Solution**:
- Verify the Site ID is correct
- Ensure the Netlify site still exists and you have access

---

## Security Notes ⚠️

- ✅ **Never commit secrets to Git** - Always use GitHub Secrets
- ✅ **Rotate tokens periodically** - Generate new tokens every few months
- ✅ **Use minimal permissions** - Netlify tokens should only have deployment access
- ✅ **Monitor usage** - Check Netlify deployment logs regularly

---

## Next Steps

After setting up secrets:

1. [ ] Get your `NETLIFY_AUTH_TOKEN`
2. [ ] Get your `NETLIFY_SITE_ID`
3. [ ] Add both secrets to GitHub repository
4. [ ] Uncomment deployment section in `flutter.yml`
5. [ ] Push changes and verify automatic deployment works

---

**Need Help?** Check [GitHub Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
