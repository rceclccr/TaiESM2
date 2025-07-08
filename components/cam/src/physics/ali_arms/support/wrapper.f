      subroutine wrapper(H_geopot,P,T,CO2,O,N2,O2,CH_rate,N_alt) 

      implicit none
      real G0, R_EARTH   
      parameter (G0 = 9.80665 ) 	! [m/s2]
      parameter (R_EARTH = 6371000.0 ) 	! [m]

      integer N_alt, i_alt
      real H_geopot(N_alt)
      real P(N_alt)
      real T(N_alt)
      real CO2(N_alt)
      real O(N_alt)
      real N2(N_alt)
      real O2(N_alt)
      real CH_rate(N_alt)
      real H(N_alt)
      real P_ali(N_alt)

      do i_alt=1,N_alt
        ! converting from geopotential to real heights and changing from m to km
        H(i_alt)=R_EARTH*H_geopot(i_alt)/(R_EARTH-H_geopot(i_alt))/1000.0 
        P(i_alt)=P(i_alt)/1e5
      enddo
      
      call ali(H,P,T,CO2,O,N2,O2,CH_rate,N_alt)

      do i_alt=1,N_alt
        CH_rate(i_alt)=-CH_rate(i_alt) ! in WACCM, cooling is positive
      enddo
        
      return
      end subroutine wrapper
