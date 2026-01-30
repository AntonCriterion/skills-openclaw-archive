---
name: attio-generic-enhanced
description: Enhanced Attio CRM integration with batch operations, improved error handling, data validation, enrichment functions, and robust task management. Use when working with large volumes of CRM data, requiring advanced error handling, or needing comprehensive data validation.
---

# Enhanced Attio CRM - Generic Version

Advanced Attio CRM integration with enhanced functionality for general-purpose CRM operations.

## Setup

Set `ATTIO_API_KEY` in environment or `~/.env`:
```bash
echo "ATTIO_API_KEY=your_api_key" >> ~/.env
```

Get your API key: Attio → Workspace Settings → Developers → New Access Token

## Enhanced Features

### 1. Batch Operations for Bulk Imports

```bash
# Import large volumes of records efficiently
attio-enhanced batch import companies data.json

# Process records in configurable chunks
attio-enhanced batch import people data.json --chunk-size 50

# Track progress during bulk operations
attio-enhanced batch import deals data.json --progress
```

### 2. Enhanced Error Handling with Retry Logic

```bash
# Automatic retry on rate limits with exponential backoff
attio-enhanced records create company data.json

# Handle connection failures gracefully
attio-enhanced records update person id data.json

# Comprehensive error reporting
attio-enhanced batch validate data.json
```

### 3. Data Validation for CRM Scenarios

```bash
# Validate data before import
attio-enhanced validate records data.json

# Check required fields and data types
attio-enhanced validate required-fields companies.json

# Custom validation rules
attio-enhanced validate custom-rules people.json
```

### 4. General-Purpose Enrichment Functions

```bash
# Enrich contact data from external sources
attio-enhanced enrich contact person_id

# Augment company information
attio-enhanced enrich company company_id

# Lookup social media profiles
attio-enhanced enrich social company_domain
```

### 5. Robust Task Management

```bash
# Create and track long-running tasks
attio-enhanced tasks create "Process 1000 records" --script process_large_batch.sh

# Monitor task status
attio-enhanced tasks status task_id

# Retrieve task results
attio-enhanced tasks results task_id
```

## Examples

### Bulk Import with Error Handling
```bash
# Import 1000 companies with automatic retry and error isolation
attio-enhanced batch import companies large_dataset.json --chunk-size 50 --retry-attempts 3
```

### Data Validation Before Import
```bash
# Validate your data before import to prevent errors
attio-enhanced validate records prospect_data.json
attio-enhanced batch import people prospect_data.json
```

### Contact Enrichment
```bash
# Enrich existing contacts with additional information
attio-enhanced enrich contact person_record_id
```

## Performance Improvements

- Async/await support for concurrent operations
- Connection pooling with session reuse
- Efficient memory usage during batch processing
- Optimized API calls with proper resource management

## Security Features

- Secure environment variable handling for credentials
- API key protection in headers only
- No hardcoded credentials in code

## Full API Docs

https://docs.attio.com/