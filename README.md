# Mayajal vulnerable machines

Each immediate machine folder is independently importable by Mayajal.

Required files:

- `machine.json`: machine metadata and runtime options.
- `Dockerfile`: the build definition for exactly one machine.

Optional files belong in an `attachments/` directory. Mayajal exposes those
files to an authorized learner only while their lab session is running.

Import example:

```http
POST /admin/machines/import-github
Authorization: Bearer <admin-token>
Content-Type: application/json

{
  "repository_url": "https://github.com/example/mayajal-vulnerable-machines",
  "ref": "main",
  "machine_path": "weak-password-login"
}
```

The importer accepts GitHub HTTPS repository URLs only, downloads the requested
ref, requires the two files above, rejects links and unsafe archive entries,
and discovers regular files beneath `attachments/`.
