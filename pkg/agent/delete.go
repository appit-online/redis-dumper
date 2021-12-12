package agent

import (
	"context"
	"fmt"
	"time"

	"github.com/appit-online/redis-dumper/pkg/core/deleter"
	"github.com/appit-online/redis-dumper/pkg/core/logger"
	"github.com/appit-online/redis-dumper/pkg/core/scanner"
	"github.com/spf13/cobra"
)

var parallelDeletes int

var deleteCmd = &cobra.Command{
	Use:   "delete <redis>",
	Short: "Delete keys from redis instance by given pattern",
	Long: `Delete keys from redis instance by given pattern 
Url can be provided as just "<host>:<port>" or in Redis URL format: "redis://[:<password>@]<host>:<port>[/<dbIndex>]"`,
	Args: cobra.MinimumNArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Start deleting keys")
		ctx := context.Background()

		// create redis clients
		scannerClient := createClient(ctx, sourcePassword, args[0], sourceUseTLS)
		deleterClient := createClient(ctx, sourcePassword, args[0], sourceUseTLS)

		// init core services
		logger := logger.CreateService()
		scanner := scanner.CreateService(
			scannerClient,
			scanner.Options{
				SearchPattern:  pattern,
				RedisScanCount: scanCount,
			},
			logger,
		)
		deleter := deleter.CreateService(
			deleterClient,
			scanner.GetScanChannel(),
			logger,
		)

		// start processing
		logger.Start(time.Second * time.Duration(logInterval))
		scanner.Start(ctx)
		deleter.Start(ctx, parallelDeletes)

		logger.Stop()
		logger.Report()

		fmt.Println("Finish deleting keys")
	},
}

func init() {
	RootCmd.AddCommand(deleteCmd)

	deleteCmd.Flags().BoolVar(&sourceUseTLS, "useTLS", true, "Enable TLS - default true")
	deleteCmd.Flags().StringVar(&pattern, "pattern", "*", "Matching pattern for keys")
	deleteCmd.Flags().StringVar(&sourcePassword, "password", "", "Password for redis")
	deleteCmd.Flags().IntVar(&scanCount, "scanCount", 1000, "COUNT parameter for redis SCAN command")
	deleteCmd.Flags().IntVar(&logInterval, "logInterval", 1, "Log current status every N seconds")
	deleteCmd.Flags().IntVar(&parallelDeletes, "parallelDeletes", 100, "Number of parallel delete goroutines")
}
