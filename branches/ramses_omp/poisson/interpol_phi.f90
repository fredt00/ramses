subroutine interpol_phi(ind_cell,phi_int,ncell,ilevel)
  use amr_commons
  use poisson_commons
  implicit none
  integer::ncell,ilevel
!  integer ,dimension(1:nvector,1:ndim)::ind_cell
!  real(dp),dimension(1:nvector,1:twotondim,1:ndim)::phi_int
  integer ,dimension(1:nvector)::ind_cell
  real(dp),dimension(1:nvector,1:twotondim)::phi_int
  !
  !
  integer::i,ind,ix,iy,iz,idim
  real(dp)::dx

  real(dp),dimension(1:twotondim,1:3)::xc
  real(dp),dimension(1:nvector)::a
  real(dp),dimension(1:nvector,1:ndim)::w

  ! Mesh size at level ilevel
  dx=0.5D0**ilevel

  ! Set position of cell centers relative to grid center
  do ind=1,twotondim
     iz=(ind-1)/4
     iy=(ind-1-4*iz)/2
     ix=(ind-1-2*iy-4*iz)
     if(ndim>0)xc(ind,1)=(dble(ix)-0.5D0)*dx
     if(ndim>1)xc(ind,2)=(dble(iy)-0.5D0)*dx
     if(ndim>2)xc(ind,3)=(dble(iz)-0.5D0)*dx
  end do

  ! Gather father potential
  do i=1,ncell
     a(i)=phi(ind_cell(i))
  end do

  ! Gather father 3-force
  do idim=1,ndim
     do i=1,ncell
        w(i,idim)=-f(ind_cell(i),idim)
     end do
  end do

  ! Interpolate
  do ind=1,twotondim
#if NDIM==1
     do i=1,ncell
        phi_int(i,ind)=a(i)+w(i,1)*xc(ind,1)
     end do
#endif
#if NDIM==2
     do i=1,ncell
        phi_int(i,ind)=a(i)+w(i,1)*xc(ind,1)+w(i,2)*xc(ind,2)
     end do
#endif
#if NDIM==3
     do i=1,ncell
        phi_int(i,ind)=a(i)+w(i,1)*xc(ind,1)+w(i,2)*xc(ind,2)+w(i,3)*xc(ind,3)
     end do
#endif
  end do

end subroutine interpol_phi


subroutine interpol_phi2(ind_cell,phi_int,ncell,ilevel)
  use amr_commons
  use poisson_commons
  implicit none
  integer::ncell,ilevel
  integer ,dimension(1:nvector)::ind_cell
  real(dp),dimension(1:nvector,1:twotondim)::phi_int
  !
  !
  integer::i,idim,ind,ix,iy,iz
  real(dp)::dx

  real(dp),dimension(1:twotondim,1:3)::xc
  real(dp),dimension(1:nvector)::a
  real(dp),dimension(1:nvector,1:ndim)::w

  ! Mesh size at level ilevel
  dx=0.5D0**ilevel

  ! Set position of cell centers relative to grid center
  do ind=1,twotondim
     iz=(ind-1)/4
     iy=(ind-1-4*iz)/2
     ix=(ind-1-2*iy-4*iz)
     if(ndim>0)xc(ind,1)=(dble(ix)-0.5D0)*dx
     if(ndim>1)xc(ind,2)=(dble(iy)-0.5D0)*dx
     if(ndim>2)xc(ind,3)=(dble(iz)-0.5D0)*dx
  end do

  ! Gather father potential
  do i=1,ncell
     a(i)=phi(ind_cell(i))
  end do

  ! Gather father 3-force
  do idim=1,ndim
     do i=1,ncell
        w(i,idim)=-f(ind_cell(i),idim)
     end do
  end do

  ! Interpolate
  do ind=1,twotondim
#if NDIM==1
     do i=1,ncell
        phi_int(i,ind)=a(i)+w(i,1)*xc(ind,1)
     end do
#endif
#if NDIM==2
     do i=1,ncell
        phi_int(i,ind)=a(i)+w(i,1)*xc(ind,1)+w(i,2)*xc(ind,2)
     end do
#endif
#if NDIM==3
     do i=1,ncell
        phi_int(i,ind)=a(i)+w(i,1)*xc(ind,1)+w(i,2)*xc(ind,2)+w(i,3)*xc(ind,3)
     end do
#endif
  end do

end subroutine interpol_phi2