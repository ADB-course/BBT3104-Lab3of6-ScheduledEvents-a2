-- CREATE EVN_average_customer_waiting_time_every_1_hour
CREATE TABLE `customer_service_kpi` (
  `customer_service_KPI_timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_service_KPI_average_waiting_time_minutes` INT NOT NULL,
  PRIMARY KEY (`customer_service_KPI_timestamp`)
);

CREATE EVENT `EVN_average_customer_waiting_time_every_1_hour`
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  INSERT INTO `customer_service_kpi` (`customer_service_KPI_average_waiting_time_minutes`)
  SELECT AVG(TIMEDIFF(`ticket_resolved_at`, `ticket_created_at`) / 60) AS `average_waiting_time_minutes`
  FROM `customer_service_ticket`
  WHERE `ticket_created_at` >= NOW() - INTERVAL 1 HOUR;
END;