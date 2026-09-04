#!/usr/bin/env bash
# 🛡️ TAB-11 – سكريبت تشغيل سريع (Quick Launcher)
# يحدّد مكتبات Qt6 ويشغل البرنامج من مجلد البناء.
#
# الإصلاحات المطبّقة:
#  - المسار ديناميكي بالكامل (لا يعتمد على اسم مستخدم مُثبّت /saicox)
#  - set -euo pipefail للحماية من الأخطاء الصامتة
#  - فحص وجود الملف التنفيذي قبل تشغيله
#  - رسائل خطأ واضحة

set -euo pipefail

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "${SCRIPT_PATH}")" && pwd)"
PROJECT_DIR="${SCRIPT_DIR}"
BUILD_DIR="${PROJECT_DIR}/build"
BINARY="${BUILD_DIR}/TAB-11"

# إضافة مسار البناء لمكتبات Qt6 المُجمَّعة محلياً (إن وجدت)
export LD_LIBRARY_PATH="${BUILD_DIR}/bin:${BUILD_DIR}/lib:${LD_LIBRARY_PATH:-}"

# التحقق من وجود الملف التنفيذي
if [ ! -f "${BINARY}" ]; then
    echo "[!] لم يتم العثور على: ${BINARY}"
    echo "[*] تأكد من تشغيل scripts/install_kali.sh أولاً لبناء المشروع."
    exit 1
fi

echo "[*] تشغيل TAB-11 من: ${BINARY}"
exec "${BINARY}" "$@"
