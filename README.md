# redis-dumper

## CLI to 
- copy data by key pattern from one redis instance to another (backup/restore)
- delete keys from redis (e.g by key pattern)
- generate dummy keys 


### Installation

- Option A 
  - Download the binary for your platform from the [releases page](https://github.com/appit-online/redis-dumper/releases).
- Option B
  - Checkout master and install locally with 
  - `go install`
- Option C
  - Install directly from GitHub 
  - `go install github.com/appit-online/redis-dumper@latest`
- Option D
  - Install with Homebrew 
  - ```brew tap appit-online/redis-dumper \  
    https://github.com/appit-online/redis-dumper
    brew install redis-dumper
    ```


## Usage


*Source*, *destination* - can be provided as just `<host>:<port>` or in Redis URL format: `redis://[:<password>@]<host>:<port>[/<dbIndex>]`
*Pattern* - can be glob-style pattern supported by [Redis SCAN](https://redis.io/commands/scan) command.


### 1) Migrate - Export/Import keys
```bash
redis-dumper migrate <source> <destination> --pattern="prefix:*" --sourcePassword="SourcePassword" --targetPassword="TargetPassword"
```

#### Other flags:
```bash
  --sourceUseTLS bool   "Enable TLS for source Redis" (default true)
  --targetUseTLS bool   "Enable TLS for target Redis" (default true)
  --logInterval int     "Print current status every N seconds" (default 1)
  --scanCount int       "COUNT parameter for redis SCAN command" (default 1000)
  --parallelDumps int   "Number of parallel dump goroutines" (default 100)
  --pushRoutines int    "Number of parallel restore goroutines" (default 100)
```

### 2) Delete keys
```bash
redis-dumper delete <redis> --pattern="prefix:*" --password="Password" 
```

#### Other flags:
```bash
  --useTLS bool   "Enable TLS" (default true)
  --logInterval int     "Print current status every N seconds" (default 1)
  --scanCount int       "COUNT parameter for redis SCAN command" (default 1000)
  --parallelDeletes int   "Number of parallel delete goroutines" (default 100)
```

### 3) Generate keys
```bash
redis-dumper generate <redis> --password="Password" 
```

#### Other flags:
```bash
  --useTLS bool   "Enable TLS" (default true)
  --prefixes []string   "List of prefixes for generated keys" (default {"mykey:", "testkey:"})
  --prefixAmount []string   "Amount of keys to create for each prefix in one iteration" (default {"1", "2"})
  --entryCount int     "Iteration count to perform" (default 1)
```

### Migration Job Details

#### Scanning
Is performed with a single goroutine, scanned keys are sent to channel

#### DUMPING
X export goroutines are consuming keys and perform `DUMP` and `PTTL` as a pipeline command

#### Restoring
Results are sent to another channel, where another Y push goroutines are performing `RESTORE`/`REPLACE` command on the destination instance

#### Monitoring
A goroutine outputs status every T seconds 
