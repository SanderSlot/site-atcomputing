#####################################################################
#                            Build Stage                            #
#####################################################################

FROM hugomods/hugo:exts-0.118.0 as builder

# Base URL
ARG HUGO_BASEURL=http://localhost:8080
ENV HUGO_BASEURL=${HUGO_BASEURL}

# Build site
COPY . /src
RUN hugo --minify --gc --enableGitInfo

# Set the fallback 404 page if defaultContentLanguageInSubdir is enabled, please replace the `en` with your default language code.
# RUN cp ./public/en/404.html ./public/404.html

#####################################################################
#                            Final Stage                            #
#####################################################################
FROM hugomods/hugo:nginx

# Copy the generated files to keep the image as small as possible.
COPY --from=builder /src/public /site



#FROM nginx
#COPY --from=hugo /target /usr/share/nginx/html