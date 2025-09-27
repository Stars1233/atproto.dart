<p align="center">
  <b>Independent DID PLC Directory client for Dart 🦋</b>
</p>

<!-- TOC -->

- [1. Guide 🌎](#1-guide-)
  - [1.1. Features ⭐](#11-features-)
  - [1.2. Installation 📦](#12-installation-)
  - [1.3. Quick Start 🚀](#13-quick-start-)
  - [1.4. API Overview 📚](#14-api-overview-)
  - [1.5. Advanced Features 🔧](#15-advanced-features-)
  - [1.6. Migration Guide 📋](#16-migration-guide-)
  - [1.7. Performance Best Practices 🚄](#17-performance-best-practices-)
  - [1.8. Examples 💡](#18-examples-)

<!-- /TOC -->

# 1. Guide 🌎

A high-performance, independent Dart library for interacting with [DID PLC Directory](https://web.plc.directory) services. This library provides a complete implementation of the DID PLC specification with zero external dependencies on atproto packages.

## 1.1. Features ⭐

- ✅ **Zero atproto Dependencies** - Completely independent implementation
- ✅ **High Performance** - Built-in caching, batching, and streaming support
- ✅ **Type Safe** - Full type safety with freezed data classes
- ✅ **Comprehensive** - Complete DID PLC specification support
- ✅ **Well Tested** - 100% test coverage with comprehensive test suite
- ✅ **Modern Dart** - Uses latest Dart features and null safety
- ✅ **Simple API** - Clean and intuitive interface for DID operations
- ✅ **Efficient Caching** - Built-in memory cache with TTL support
- ✅ **Batch Processing** - Process multiple DIDs efficiently

## 1.2. Installation 📦

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  did_plc: ^1.0.0
```

Then run:

```bash
dart pub get
```

## 1.3. Quick Start 🚀

```dart
import 'package:did_plc/did_plc.dart';

Future<void> main() async {
  // Create a PLC client
  final plc = PLC();

  try {
    // Fetch a DID document
    final document = await plc.findDocument('did:plc:iijrtk7ocored6zuziwmqq3c');
    print('DID Document: ${document.id}');
    
    // Get operation log
    final operationLog = await plc.findOperationLog('did:plc:iijrtk7ocored6zuziwmqq3c');
    print('Operations: ${operationLog.operations.length}');
    
  } on NetworkException catch (e) {
    print('Network error: ${e.message}');
  } on PlcException catch (e) {
    print('PLC error: ${e.message}');
  } finally {
    // Always close the client
    plc.close();
  }
}
```

## 1.4. API Overview 📚

### Core Operations

```dart
final plc = PLC();

// Document operations
final document = await plc.findDocument(did);
final documentData = await plc.findDocumentData(did);

// Operation log operations
final operationLog = await plc.findOperationLog(did);
final auditLog = await plc.findAuditLog(did);
final lastOperation = await plc.findLastOperation(did);

// Batch operations
final documents = await plc.findDocuments([did1, did2, did3]);

// Health check
final health = await plc.health();
```

### Advanced Features

```dart
// Custom configuration with comprehensive options
final plc = PLC(
  service: 'https://plc.directory',
  cachePolicy: CachePolicy(
    ttl: Duration(minutes: 10),
    maxSize: 1000,
    evictionPolicy: EvictionPolicy.lru,
  ),
  retryPolicy: RetryPolicy(
    maxAttempts: 3,
    initialDelay: Duration(seconds: 1),
    backoffMultiplier: 2.0,
  ),
  httpTimeout: Duration(seconds: 30),
  maxConcurrentRequests: 10,
);

// Streaming large datasets with backpressure control
await for (final entry in plc.exportStream(
  bufferSize: 1000,
  maxConcurrency: 5,
)) {
  print('Processing: ${entry.did}');
}
```

## 1.5. Advanced Features 🔧

### Caching

Built-in intelligent caching reduces network requests and improves performance:

```dart
final plc = PLC(
  cachePolicy: CachePolicy(
    ttl: Duration(minutes: 15),      // Cache for 15 minutes
    maxSize: 2000,                   // Maximum 2000 entries
    evictionPolicy: EvictionPolicy.lru, // LRU eviction
  ),
);
```

### Batch Processing

Efficiently process multiple DIDs in parallel:

```dart
final dids = ['did:plc:abc123', 'did:plc:def456', 'did:plc:ghi789'];
final documents = await plc.findDocuments(dids);

// Process results
for (final entry in documents.entries) {
  print('${entry.key}: ${entry.value.id}');
}
```

### Streaming

Handle large datasets efficiently with streaming:

```dart
await for (final entry in plc.exportStream(
  after: DateTime.now().subtract(Duration(days: 1)),
  count: 1000,
)) {
  // Process each entry as it arrives
  await processAuditLogEntry(entry);
}
```

### Cryptographic Operations

Create and verify PLC operations:

```dart
// Create operation builder
final builder = OperationBuilder()
  ..type = 'plc_operation'
  ..rotationKeys = ['did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK']
  ..verificationMethods = {
    'atproto': 'did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK'
  };

// Sign and submit operation
final operation = await plc.createOperation(builder);
final cid = await plc.submitOperation(operation);
```

## 1.6. Migration Guide 📋

### From atproto-dependent version

If you're migrating from a version that depended on `atproto_core`:

#### Before (atproto-dependent):
```dart
import 'package:atproto/atproto.dart' as atproto;
import 'package:did_plc/did_plc.dart' as plc;

final session = atproto.Session.fromJson(sessionData);
final plcClient = plc.PLC(session: session);
```

#### After (independent):
```dart
import 'package:did_plc/did_plc.dart';

// No session needed - direct PLC directory access
final plc = PLC();
```

#### Key Changes:

1. **No Session Required**: Direct access to PLC directory without authentication
2. **New Import Structure**: Single import covers all functionality
3. **Enhanced Error Handling**: More specific exception types
4. **Improved Performance**: Built-in caching and batching

### Data Type Changes

#### Before:
```dart
// Old entity classes
import 'package:did_plc/src/entities/did_document.dart';
```

#### After:
```dart
// New freezed types
import 'package:did_plc/did_plc.dart'; // All types included

// Types are now immutable and have better JSON support
final document = DidDocument.fromJson(jsonData);
final copy = document.copyWith(id: 'new-id');
```

## 1.7. Performance Best Practices 🚄

### 1. Use Caching Effectively

```dart
// Configure appropriate cache settings
final plc = PLC(
  cachePolicy: CachePolicy(
    ttl: Duration(minutes: 10),  // Adjust based on your use case
    maxSize: 1000,               // Prevent memory bloat
  ),
);
```

### 2. Batch Multiple Requests

```dart
// Instead of multiple individual requests
final doc1 = await plc.findDocument(did1);
final doc2 = await plc.findDocument(did2);
final doc3 = await plc.findDocument(did3);

// Use batch processing
final documents = await plc.findDocuments([did1, did2, did3]);
```

### 3. Use Streaming for Large Datasets

```dart
// For processing large amounts of data
await for (final entry in plc.exportStream(count: 10000)) {
  // Process incrementally to avoid memory issues
  await processEntry(entry);
}
```

### 4. Configure Retry Policies

```dart
final plc = PLC(
  retryPolicy: RetryPolicy(
    maxAttempts: 3,
    initialDelay: Duration(milliseconds: 500),
    backoffMultiplier: 2.0,
  ),
);
```

### 5. Proper Resource Management

```dart
Future<void> processDocuments() async {
  final plc = PLC();
  try {
    // Your processing logic
    await plc.findDocument(did);
  } finally {
    // Always close to free resources
    plc.close();
  }
}

// Or use automatic resource management
await PLC.withClient((plc) async {
  return await plc.findDocument(did);
});
```

### 6. Performance Monitoring

```dart
// Monitor cache performance
final stats = plc.cacheStats;
print('Cache hit rate: ${stats.hitRate}%');
print('Memory usage: ${stats.memoryUsage}MB');

// Monitor concurrent operations
final metrics = plc.performanceMetrics;
print('Active requests: ${metrics.activeRequests}');
print('Average response time: ${metrics.avgResponseTime}ms');
```

## 1.8. Examples 💡

See the [examples](example/) directory for complete working examples:

- [Basic Usage](example/example.dart) - Simple DID document retrieval
- [Caching Example](example/cache_example.dart) - Advanced caching configuration
- [Streaming Example](example/streaming_example.dart) - Large dataset processing
- [Batch Processing](example/batch_example.dart) - Efficient multiple DID handling
- [Cryptographic Operations](example/crypto_example.dart) - Creating and verifying operations
- [Error Handling](example/error_handling_example.dart) - Comprehensive error management

For more detailed documentation, see:
- [API Reference](https://pub.dev/documentation/did_plc/latest/)
- [Migration Guide](MIGRATION.md)
- [Performance Guide](PERFORMANCE.md)
