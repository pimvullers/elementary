# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

GVDB_COMMIT="466fc22016cf0981424e7121557611942191992f"

DESCRIPTION="Parental controls support library"
HOMEPAGE="https://gitlab.freedesktop.org/pwithnall/malcontent"
SRC_URI="
	https://gitlab.freedesktop.org/pwithnall/malcontent/-/archive/${PV}/${P}.tar.bz2
	https://gitlab.gnome.org/GNOME/gvdb/-/archive/${GVDB_COMMIT}/gvdb-${GVDB_COMMIT}.tar.bz2
	https://www.corpit.ru/mjt/tinycdb/tinycdb-0.81.tar.gz
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/appstream
	>=dev-libs/glib-2.50:2
	dev-libs/libgsystemservice
	dev-libs/gobject-introspection
	sys-apps/flatpak
	sys-apps/accountsservice
	sys-auth/polkit
	sys-libs/pam
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
	dev-util/gi-docgen
	virtual/pkgconfig
"

src_unpack() {
	default
	rm -rf "${S}/subprojects/gvdb"
	mv "${WORKDIR}/gvdb-${GVDB_COMMIT}" "${S}/subprojects/gvdb" || die
	mv "${WORKDIR}/tinycdb-0.81" "${S}/subprojects/tinycdb-0.81" || die
	cp "${S}/subprojects/packagefiles/tinycdb/meson.build" \
		"${S}/subprojects/tinycdb-0.81/meson.build" || die
}

src_prepare() {
	eapply_user
	sed -i "/subdir('tests')/d" \
		meson.build \
		libmalcontent-ui/meson.build \
		libmalcontent/meson.build \
		libmalcontent-timer/meson.build \
		libmalcontent-web/meson.build \
		malcontent-control/meson.build \
		malcontent-timer-extension-agent/meson.build \
		malcontent-timerd/meson.build \
		malcontent-webd-update/meson.build \
		malcontent-webd/meson.build \
		nss/meson.build \
		pam/meson.build
	vala_setup
}
