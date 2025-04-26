import React from 'react';
import { Container, Typography, Grid, Card, CardContent, Button, Box } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import { services } from '../data/mockData';

const Services = () => {
  return (
    <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
      <Typography variant="h3" component="h1" gutterBottom align="center">
        خدماتنا
      </Typography>
      <Typography variant="h5" component="h2" gutterBottom align="center" color="text.secondary">
        اختر القسم الذي تريد استعراض خدماته
      </Typography>

      <Grid container spacing={4} sx={{ mt: 4 }}>
        {Object.entries(services).map(([key, department]) => (
          <Grid item xs={12} sm={6} md={3} key={key}>
            <Card>
              <CardContent>
                <Typography variant="h5" component="h2" gutterBottom>
                  {department.title}
                </Typography>
                <Typography variant="body2" color="text.secondary" paragraph>
                  {department.services.length} خدمة متاحة
                </Typography>
                <Box sx={{ mt: 2 }}>
                  <Button
                    variant="contained"
                    component={RouterLink}
                    to={`/services/${key}`}
                    fullWidth
                  >
                    عرض الخدمات
                  </Button>
                </Box>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>

      <Box sx={{ mt: 6, textAlign: 'center' }}>
        <Typography variant="h4" gutterBottom>
          أنواع الخدمات المتوفرة
        </Typography>
        <Grid container spacing={4} sx={{ mt: 2 }}>
          <Grid item xs={12} md={4}>
            <Typography variant="h6" gutterBottom>
              البحث العلمي
            </Typography>
            <Typography>
              خدمات البحث العلمي في مختلف المجالات
            </Typography>
          </Grid>
          <Grid item xs={12} md={4}>
            <Typography variant="h6" gutterBottom>
              الشهادات المهنية
            </Typography>
            <Typography>
              شهادات معتمدة في مختلف التخصصات
            </Typography>
          </Grid>
          <Grid item xs={12} md={4}>
            <Typography variant="h6" gutterBottom>
              الدورات التدريبية
            </Typography>
            <Typography>
              دورات تدريبية متخصصة في مختلف المجالات
            </Typography>
          </Grid>
          <Grid item xs={12} md={4}>
            <Typography variant="h6" gutterBottom>
              الاستشارات
            </Typography>
            <Typography>
              استشارات متخصصة في مختلف المجالات
            </Typography>
          </Grid>
          <Grid item xs={12} md={4}>
            <Typography variant="h6" gutterBottom>
              التطوع
            </Typography>
            <Typography>
              فرص تطوعية في مختلف المجالات
            </Typography>
          </Grid>
        </Grid>
      </Box>
    </Container>
  );
};

export default Services; 