<h1 align="center" style="border-bottom: none">
  <div>
    <a href="https://www.bsign.com">
      <img  alt="bsign" src="https://github.com/docusealco/bsign/assets/5418788/c12cd051-81cd-4402-bc3a-92f2cfdc1b06" width="80" />
      <br>
    </a>
    bsign
  </div>
</h1>
<h3 align="center">
  Open source document filling and signing
</h3>
<p align="center">
  <a href="https://hub.docker.com/r/bsign/bsign">
    <img alt="Docker releases" src="https://img.shields.io/docker/v/bsign/bsign">
  </a>
  <a href="https://discord.gg/qygYCDGck9">
    <img src="https://img.shields.io/discord/1125112641170448454?logo=discord"/>
  </a>
  <a href="https://twitter.com/intent/follow?screen_name=docusealco">
    <img src="https://img.shields.io/twitter/follow/docusealco?style=social" alt="Follow @docusealco" />
  </a>
</p>
<p>
bsign is an open source platform that provides secure and efficient digital document signing and processing. Create PDF forms to have them filled and signed online on any device with an easy-to-use, mobile-optimized web tool.
</p>
<h2 align="center">
  <a href="https://demo.bsign.tech">✨ Live Demo</a>
  <span>|</span>
  <a href="https://bsign.com/sign_up">☁️ Try in Cloud</a>
</h2>

[![Demo](https://github.com/docusealco/bsign/assets/5418788/d8703ea3-361a-423f-8bfe-eff1bd9dbe14)](https://demo.bsign.tech)

## Features
- PDF form fields builder (WYSIWYG)
- 12 field types available (Signature, Date, File, Checkbox etc.)
- Multiple submitters per document
- Automated emails via SMTP
- Files storage on disk or AWS S3, Google Storage, Azure Cloud
- Automatic PDF eSignature
- PDF signature verification
- Users management
- Mobile-optimized
- 6 UI languages with signing available in 14 languages
- API and Webhooks for integrations
- Easy to deploy in minutes

## Pro Features
- Company logo and white-label
- User roles
- Automated reminders
- Invitation and identify verification via SMS
- Conditional fields and formulas
- Bulk send with CSV, XLSX spreadsheet import
- SSO / SAML
- Template creation with HTML API ([Guide](https://www.bsign.com/guides/create-pdf-document-fillable-form-with-html-api))
- Template creation with PDF or DOCX and field tags API ([Guide](https://www.bsign.com/guides/use-embedded-text-field-tags-in-the-pdf-to-create-a-fillable-form))
- Embedded signing form ([React](https://github.com/docusealco/bsign-react), [Vue](https://github.com/docusealco/bsign-vue), [Angular](https://github.com/docusealco/bsign-angular) or [JavaScript](https://www.bsign.com/docs/embedded))
- Embedded document form builder ([React](https://github.com/docusealco/bsign-react), [Vue](https://github.com/docusealco/bsign-vue), [Angular](https://github.com/docusealco/bsign-angular) or [JavaScript](https://www.bsign.com/docs/embedded))
- [Learn more](https://www.bsign.com/pricing)

## Deploy

|Heroku|Railway|
|:--:|:---:|
| [<img alt="Deploy on Heroku" src="https://www.herokucdn.com/deploy/button.svg" height="40">](https://heroku.com/deploy?template=https://github.com/docusealco/bsign-heroku) | [<img alt="Deploy on Railway" src="https://railway.app/button.svg" height="40">](https://railway.app/template/IGoDnc?referralCode=ruU7JR)|
|**DigitalOcean**|**Render**|
| [<img alt="Deploy on DigitalOcean" src="https://www.deploytodo.com/do-btn-blue.svg" height="40">](https://cloud.digitalocean.com/apps/new?repo=https://github.com/docusealco/bsign-digitalocean/tree/master&refcode=421d50f53990) | [<img alt="Deploy to Render" src="https://render.com/images/deploy-to-render-button.svg" height="40">](https://render.com/deploy?repo=https://github.com/docusealco/bsign-render)

#### Docker

```sh
docker run --name bsign -p 3000:3000 -v.:/data bsign/bsign
```

By default bsign docker container uses an SQLite database to store data and configurations. Alternatively, it is possible use PostgreSQL or MySQL databases by specifying the `DATABASE_URL` env variable.

#### Docker Compose

Download docker-compose.yml into your private server:
```sh
curl https://raw.githubusercontent.com/docusealco/bsign/master/docker-compose.yml > docker-compose.yml
```

Run the app under a custom domain over https using docker compose (make sure your DNS points to the server to automatically issue ssl certs with Caddy):
```sh
sudo HOST=your-domain-name.com docker compose up
```

## For Businesses
### Integrate seamless document signing into your web or mobile apps with bsign

At bsign we have expertise and technologies to make documents creation, filling, signing and processing seamlessly integrated with your product. We specialize in working with various industries, including **Banking, Healthcare, Transport, Real Estate, eCommerce, KYC, CRM, and other software products** that require bulk document signing. By leveraging bsign, we can assist in reducing the overall cost of developing and processing electronic documents while ensuring security and compliance with local electronic document laws.

[Book a Meeting](https://www.bsign.com/contact)

## License

Distributed under the AGPLv3 License. See [LICENSE](https://github.com/docusealco/bsign/blob/master/LICENSE) for more information.
Unless otherwise noted, all files © 2023 bsign LLC.

## Tools

- [Signature Maker](https://www.bsign.com/online-signature)
- [Sign Document Online](https://www.bsign.com/sign-documents-online)
- [Fill PDF Online](https://www.bsign.com/fill-pdf)
