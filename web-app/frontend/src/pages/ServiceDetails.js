import React from 'react';
import { useParams } from 'react-router-dom';
import { Container, Typography, Grid, Card, CardContent, Button, Box } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import { services, members } from '../data/mockData';

const ServiceDetails = () => {
  const { department } = useParams();
  const departmentServices = services[department];
  const departmentMembers = members.filter(member => member.department === department);

  return (
    <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
      <Typography variant="h3" component="h1" gutterBottom align="center">
        {departmentServices.title}
      </Typography>

      <Grid container spacing={4} sx={{ mt: 4 }}>
        {departmentServices.services.map((service) => (
          <Grid item xs={12} md={6} key={service.id}>
            <Card>
              <CardContent>
                <Typography variant="h5" component="h2" gutterBottom>
                  {service.title}
                </Typography>
                <Typography variant="body1" paragraph>
                  {service.description}
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  السعر: {service.price}
                </Typography>
                <Box sx={{ mt: 2 }}>
                  <Button
                    variant="contained"
                    component={RouterLink}
                    to="/request"
                    fullWidth
                  >
                    تقديم طلب
                  </Button>
                </Box>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>

      <Box sx={{ mt: 6 }}>
        <Typography variant="h4" gutterBottom align="center">
          المختصون في هذا القسم
        </Typography>
        <Grid container spacing={4} sx={{ mt: 2 }}>
          {departmentMembers.map((member) => (
            <Grid item xs={12} sm={6} md={4} key={member.id}>
              <Card>
                <CardContent>
                  <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                    <img
                      src={member.image}
                      alt={member.name}
                      style={{ width: 80, height: 80, borderRadius: '50%', marginLeft: 16 }}
                    />
                    <Box>
                      <Typography variant="h6">{member.name}</Typography>
                      <Typography variant="body2" color="text.secondary">
                        {member.specialization}
                      </Typography>
                    </Box>
                  </Box>
                  <Typography variant="body2" paragraph>
                    {member.bio}
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    الخبرة: {member.experience}
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    التقييم: {member.rating}/5
                  </Typography>
                  <Box sx={{ mt: 2 }}>
                    <Button
                      variant="outlined"
                      component={RouterLink}
                      to={`/member/${member.id}`}
                      fullWidth
                    >
                      عرض الملف الشخصي
                    </Button>
                  </Box>
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>
      </Box>
    </Container>
  );
};

export default ServiceDetails; 