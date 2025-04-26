import React from 'react';
import { AppBar, Toolbar, Typography, Button, Box } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';

const Navbar = () => {
  return (
    <AppBar position="static">
      <Toolbar>
        <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
          منصة الخدمات المهنية
        </Typography>
        <Box sx={{ display: 'flex', gap: 2 }}>
          <Button color="inherit" component={RouterLink} to="/">
            الرئيسية
          </Button>
          <Button color="inherit" component={RouterLink} to="/services">
            الخدمات
          </Button>
          <Button color="inherit" component={RouterLink} to="/request">
            تقديم طلب
          </Button>
          <Button color="inherit" component={RouterLink} to="/managing-team">
            لوحة الإدارة
          </Button>
          <Button color="inherit" component={RouterLink} to="/member-dashboard">
            لوحة الأعضاء
          </Button>
        </Box>
      </Toolbar>
    </AppBar>
  );
};

export default Navbar; 