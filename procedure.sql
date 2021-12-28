-- PROCEDURE
-- ищет название вакцины по производителю
CREATE OR REPLACE PROCEDURE man_vaccine(manuf text)
LANGUAGE plpgsql AS
$$
  DECLARE
    nm record;
  BEGIN
    FOR nm IN
      SELECT vaccines.name
      FROM vaccines
      INNER JOIN manufacturer ON vaccines.mnf_id = manufacturer.mnf_id
      WHERE manufacturer.mnf_name = manuf
    LOOP
      RAISE INFO 'Vaccine is %', nm.name;
    END LOOP;
  END;
$$
