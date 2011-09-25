PRO PLACE_CLOUDS, global_centre_x, global_centre_y, grid_aerosol_type, grid_aerosol_amount, grid_precip_water_content
  ; Get cloud array from SAV file
  restore, "D:\Data\RTWRTM\CACloud.sav"
  cloud = c
  
  help, grid_aerosol_type
  
  dims = SIZE(cloud, /dimensions)
  local_centre_x = dims[0] / 2
  local_centre_y = dims[1] / 2
  
  FOR r = 0, dims[0] - 1 DO BEGIN
    FOR c = 0, dims[1] - 1 DO BEGIN
      value = cloud[r, c]
      
      ; If it's not part of the cloud (part of the blank area around it) then ignore this pixel
      IF value EQ 0 THEN CONTINUE
      
      x_offset = c - local_centre_x
      y_offset = r - local_centre_y
      
      value_x = global_centre_x + x_offset
      value_y = global_centre_y + y_offset
      
      PLACE_AEROSOL_TYPE, value_x, value_y, value, grid_aerosol_type
      PLACE_AEROSOL_AMOUNT, value_x, value_y, value, grid_aerosol_amount
      PLACE_PWC, value_x, value_y, value, grid_precip_water_content
    ENDFOR
  ENDFOR
END