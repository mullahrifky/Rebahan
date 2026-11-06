# ============================================================
# REBAHAN - Sistem Kinerja Tim BPS
# Static site served via nginx
# ============================================================
FROM nginx:1.27-alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy all static project files
COPY index.html /usr/share/nginx/html/index.html
COPY video_iklan_rebahan.html /usr/share/nginx/html/video_iklan_rebahan.html
COPY PANDUAN_ALUR_KERJA.pdf /usr/share/nginx/html/PANDUAN_ALUR_KERJA.pdf

# Expose HTTP port (Coolify's Traefik handles SSL termination externally)
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD wget -qO- http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
