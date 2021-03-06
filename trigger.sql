-- TRIGGER

CREATE OR REPLACE FUNCTION is_country() RETURNS trigger AS
$$
  DECLARE
  
  BEGIN
  	RAISE NOTICE 'NEW:%',NEW;
	NEW.country_name := 'Country is ' || NEW.country_name;
	return NEW;
	
  END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER country_updater
 BEFORE INSERT ON origin_country
 FOR EACH ROW EXECUTE FUNCTION is_country();
