import '../media/media_kind.dart';
import '../media/media_server_client.dart';
import '../services/jellyfin_client.dart';
import 'jellyfin_metadata_edit_adapter.dart';
import 'metadata_edit_models.dart';

MetadataEditAdapter? metadataEditAdapterFor(MediaServerClient client) {
  if (client is JellyfinClient) return JellyfinMetadataEditAdapter(client);
  return null;
}

bool supportsMetadataEdit(MediaServerClient? client, MediaKind? kind) {
  if (client == null || kind == null) return false;
  return metadataEditAdapterFor(client)?.supportsKind(kind) ?? false;
}
