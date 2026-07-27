# Mayajal vulnerable machines

This repository contains vulnerable machines for the self-hosted Mayajal
cybersecurity practice lab.

Each immediate machine folder is independently importable by Mayajal.

Required files:

- `machine.json`: machine metadata and runtime options.
- `Dockerfile`: the build definition for exactly one machine.

Optional files belong in an `attachments/` directory. Mayajal exposes those
files to an authorized learner only while their lab session is running.

Every machine must also declare at least one detection source in `machine.json`:

- Network detections are Suricata `.rules` files under `detections/network/`.
- Container/application log detections are JSON rules under
  `detections/application-logs/`.
- System, syslog, journald, or audit detections are JSON rules under
  `detections/system-logs/`.

The `detection.network.suricata`, `detection.logs.application`, and
`detection.logs.system` arrays determine which engine loads each file. Network
rules are installed in the lab Suricata configuration at startup. Log rules are
applied to the machine's session telemetry before ATT&CK attack-chain mapping.

A log rule contains `id`, `field`, `pattern`, `tactic`, `technique_id`,
`technique`, and `rationale`. `pattern` is a case-insensitive regular expression
against the selected dotted event field. Application rules ignore Suricata and
system telemetry; system rules require a system/syslog/journald/audit source.

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
