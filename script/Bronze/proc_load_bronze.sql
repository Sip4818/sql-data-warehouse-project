/*
*/

use DataWarehouse
exec bronze.load_bronze
Create or alter procedure bronze.load_bronze as
begin
	begin try
		declare @start_time datetime, @end_time datetime, @batch_start_time datetime,@batch_end_time datetime;
		set @batch_start_time=getdate()
		print'===========================';
		print'Loding Bronze layer';
		print'===========================';
		print'---------------------------'
		print'Loading CRM Tables'
		print'---------------------------'
		set @start_time=GETDATE();
		print'Truncating the Table bronze.crm_cust_info'
		truncate table bronze.crm_cust_info
		print'Inserting the Data into bronze.crm_cust_info'
			
		BULK INSERT bronze.crm_cust_info

		from 'D:\learnbay\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			TABLOCK

		);
		set @end_time=GETDATE();
		print'Loading duration: '+ cast(Datediff(second,@start_time,@end_time) as nvarchar) + ' sec'
		print'---------------------------'
		set @start_time=GETDATE();

		print'Truncating the Table bronze.crm_prd_info'
		truncate table bronze.crm_prd_info
		print'Inserting the Data into bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		from 'D:\learnbay\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			TABLOCK

		)
		set @end_time=GETDATE();
		print'Loading duration: '+ cast(Datediff(second,@start_time,@end_time) as nvarchar) + ' sec'
		print'---------------------------'
		set @start_time=GETDATE();

		print'Truncating the Table bronze.crm_sales_details'

		truncate table bronze.crm_sales_details
		print'Inserting the Data into bronze.crm_sales_details'

		BULK INSERT bronze.crm_sales_details
		from 'D:\learnbay\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			TABLOCK

		)
		set @end_time=GETDATE();
		print'Loading duration: '+ cast(Datediff(second,@start_time,@end_time) as nvarchar) + ' sec'
		print'---------------------------'

		print'==========================='
		print'Loading ERP Tables'
		print'==========================='
		set @start_time=GETDATE();

		print'Truncating the Table table bronze.erp_CUST_AZ12'
		truncate table bronze.erp_CUST_AZ12
		print'Inserting the Data into bronze.erp_CUST_AZ12'

		BULK INSERT bronze.erp_CUST_AZ12
		from 'D:\learnbay\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			TABLOCK

		)
		set @end_time=GETDATE();
		print'Loading duration: '+ cast(Datediff(second,@start_time,@end_time) as nvarchar) + ' sec'
		print'---------------------------'
		set @start_time=GETDATE();

		print'Truncating the Table table bronze.erp_LOC_A101'
		truncate table bronze.erp_LOC_A101
		print'Inserting the Data Into bronze.erp_LOC_A101'

		BULK INSERT bronze.erp_LOC_A101
		from 'D:\learnbay\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			TABLOCK

		)
		set @end_time=GETDATE();
		print'Loading duration: '+ cast(Datediff(second,@start_time,@end_time) as nvarchar) + ' sec'
		print'---------------------------'
		set @start_time=GETDATE();
		print'Truncating the Table bronze.erp_PX_CAT_G1V2'
		truncate table bronze.erp_PX_CAT_G1V2
		print'Inserting the Data into bronze.erp_PX_CAT_G1V2'

		BULK INSERT bronze.erp_PX_CAT_G1V2
		from 'D:\learnbay\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			TABLOCK

		)
				set @end_time=GETDATE();
		print'Loading duration: '+ cast(Datediff(second,@start_time,@end_time) as nvarchar) + ' sec'
		print'---------------------------'
		set @batch_end_time=getdate()
		print'===========================';
		print'Loding Bronze layer Complete';
		print'Batch duration: '+ cast(Datediff(second,@batch_start_time,@batch_end_time) as nvarchar) + ' sec'

		print'===========================';

	end try
	begin catch
		print'===========================';
		print'Error occured while loading the Bronze layer';
		print'Error message' + Error_message();
		print'Error message' + cast(Error_number() as nvarchar);
		print'Error message' + cast(Error_state() as nvarchar);
		print'Error occured while loading the Bronze layer';
		print'===========================';


	End catch
end
