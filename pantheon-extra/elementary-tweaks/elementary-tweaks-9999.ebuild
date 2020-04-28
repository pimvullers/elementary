# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.22
VALA_MAX_API_VERSION=0.44

inherit git-r3 gnome2-utils meson vala xdg-utils

DESCRIPTION="Elementary OS customization tool"
HOMEPAGE="https://github.com/elementary-tweaks"
EGIT_REPO_URI="https://github.com/elementary-tweaks/elementary-tweaks.git"
EGIT_COMMIT="47574c8b64e1d362db5055b82334717515977a73"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

DEPEND="
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite
	dev-libs/libgee:0.8
	gnome-base/gconf:2
	pantheon-base/switchboard
	sys-auth/polkit
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
