import React from 'react';
import { Container, Typography, Grid, Card, CardContent, Button, Box } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import { services } from '../data/mockData';

const Home = () => {
  return (
    <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
      <Typography variant="h3" component="h1" gutterBottom align="center">
        مرحباً بكم في منصة الخدمات المهنية
      </Typography>
      <Typography variant="h5" component="h2" gutterBottom align="center" color="text.secondary">
        نقدم مجموعة واسعة من الخدمات المهنية في مختلف المجالات
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
          كيف تعمل منصتنا؟
        </Typography>
        <Grid container spacing={4} sx={{ mt: 2 }}>
          <Grid item xs={12} md={4}>
            <Typography variant="h6" gutterBottom>
              ١. تصفح الخدمات
            </Typography>
            <Typography>
              اختر من بين مجموعة واسعة من الخدمات المهنية في مختلف المجالات
            </Typography>
          </Grid>
          <Grid item xs={12} md={4}>
            <Typography variant="h6" gutterBottom>
              ٢. اختر المختص
            </Typography>
            <Typography>
              اختر المختص المناسب من خلال الاطلاع على ملفاته الشخصية وخبراتهم
            </Typography>
          </Grid>
          <Grid item xs={12} md={4}>
            <Typography variant="h6" gutterBottom>
              ٣. قدم طلبك
            </Typography>
            <Typography>
              قم بتقديم طلبك وسيقوم فريق الإدارة بمراجعته وتوجيهه للمختص المناسب
            </Typography>
          </Grid>
        </Grid>
      </Box>
    </Container>
  );
};

export default Home; 